import Foundation

class ChunkedMediaDecoder {
    private var dataBuffer: Data = Data()
    private var chunks: [Data] = []
    private var chunkLength: Int = 0
    
    func decode(data: Data) -> [Data] {
        dataBuffer.append(data)
        
        while true {
            if chunkLength == 0 {
                if let range = dataBuffer.range(of: "\r\n".data(using: .utf8)!) {
                    if let chunkHeader = String(data: dataBuffer[..<range.lowerBound], encoding: .utf8) {
                        if let size = Int(chunkHeader, radix: 16) {
                            chunkLength = size
                            dataBuffer = dataBuffer[range.upperBound...]
                        } else {
                            // Invalid chunk size, discard buffer
                            dataBuffer = Data()
                            break
                        }
                    } else {
                        // Invalid chunk header, discard buffer
                        dataBuffer = Data()
                        break
                    }
                } else {
                    // Not enough data for a complete chunk header, wait for more data
                    break
                }
            }
            
            if dataBuffer.count >= chunkLength {
                let chunk = dataBuffer.prefix(chunkLength)
                chunks.append(chunk)
                
                dataBuffer = dataBuffer.dropFirst(chunkLength)
                chunkLength = 0
                
                // Check for end of stream
                if chunk.count == 0 {
                    return chunks
                }
            } else {
                // Not enough data for a complete chunk, wait for more data
                break
            }
        }
        
        return chunks
    }
}
