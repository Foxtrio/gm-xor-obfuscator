# 🔐 GM-XOR Obfuscator

> **Simple string obfuscation for GameMaker save data.**

![GameMaker](https://img.shields.io/badge/GameMaker-2023+-black?style=flat-square&logo=gamemaker&logoColor=white)
![License](https://img.shields.io/badge/License-Unlicense-blue?style=flat-square)

Two functions for obfuscating and restoring strings using XOR + Base64. Useful for keeping save files and local config values from being casually opened in a text editor.

---

## ⚠️ Read this before using it

This is **obfuscation, not encryption**. XOR with a static key is trivial to reverse for anyone who:
- Decompiles or extracts strings from your compiled game, or
- Has two known plaintext/ciphertext pairs (a classic XOR-key recovery attack)

Use it for:
- Local save files, to stop casual save-editing
- Hiding config values from a quick file peek

**Do not use it for:**
- Purchase receipts, entitlements, or anything a client shouldn't be able to forge
- Auth tokens, credentials, or anything that needs real confidentiality
- Any value your server trusts without independently re-verifying it

If you need actual security guarantees, verify state server-side. Don't rely on client-side obfuscation as the boundary.

---

## 📦 Usage

```gml
// Obfuscate a string
var packed = xor_encrypt("playerTestPinForTreasureRoom");

// Restore it
var original = xor_decrypt(packed);
```

Both functions take an optional `key` parameter if you want something other than the default:

```gml
var packed = xor_encrypt("playerTestPinForTreasureRoom", "myCustomKey123");
var original = xor_decrypt(packed, "myCustomKey123");
```

Or simply obfuscate a struct for more complex operations:
```gml
var information = {
    PlayerGold : 1000,
    TreasureKey : "michael_scofield",
    What : "idk",
}

var packed = xor_encrypt(json_stringify(information), "yourEncryptionKey");
var original = xor_decrypt(packed, "yourEncryptionKey");

show_debug_message(original.PlayerGold);
```
---

## 📄 License

Unlicense - do whatever you want with it.
