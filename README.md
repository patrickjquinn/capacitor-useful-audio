# capacitor-useful-audio

An audio plugin for capacitor that is actually useful, support the major kinds of audio interactions you might need.

## Install

```bash
npm install capacitor-useful-audio
npx cap sync
```

## API

<docgen-index>

* [`play64(...)`](#play64)
* [`playLocalAudio(...)`](#playlocalaudio)
* [`playUrl(...)`](#playurl)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### play64(...)

```typescript
play64(options: { base64: string; }) => Promise<any>
```

| Param         | Type                             |
| ------------- | -------------------------------- |
| **`options`** | <code>{ base64: string; }</code> |

**Returns:** <code>Promise&lt;any&gt;</code>

--------------------


### playLocalAudio(...)

```typescript
playLocalAudio(options: { path: string; }) => Promise<any>
```

| Param         | Type                           |
| ------------- | ------------------------------ |
| **`options`** | <code>{ path: string; }</code> |

**Returns:** <code>Promise&lt;any&gt;</code>

--------------------


### playUrl(...)

```typescript
playUrl(options: { url: string; }) => Promise<any>
```

| Param         | Type                          |
| ------------- | ----------------------------- |
| **`options`** | <code>{ url: string; }</code> |

**Returns:** <code>Promise&lt;any&gt;</code>

--------------------

</docgen-api>
