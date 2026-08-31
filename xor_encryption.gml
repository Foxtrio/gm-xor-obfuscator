function xor_encrypt(data, key = "withRegardsFromFoxtriolol") {
    var src = buffer_create(1, buffer_grow, 1);
    buffer_write(src, buffer_string, data);
    var size = buffer_tell(src);

    var dst = buffer_create(size, buffer_fixed, 1);
    var key_len = string_length(key);

    buffer_seek(src, buffer_seek_start, 0);
    for (var i = 0; i < size; i++) {
        var b = buffer_read(src, buffer_u8);
        var k = ord(string_char_at(key, (i mod key_len) + 1));
        buffer_write(dst, buffer_u8, b ^ k);
    }

    var result = buffer_base64_encode(dst, 0, size);

    buffer_delete(src);
    buffer_delete(dst);
    return result;
}

function xor_decrypt(encoded_data, key = "withRegardsFromFoxtriolol") {
    var src = buffer_base64_decode(encoded_data);
    var size = buffer_get_size(src);
    var key_len = string_length(key);

    var dst = buffer_create(size, buffer_fixed, 1);

    buffer_seek(src, buffer_seek_start, 0);
    for (var i = 0; i < size; i++) {
        var b = buffer_read(src, buffer_u8);
        var k = ord(string_char_at(key, (i mod key_len) + 1));
        buffer_write(dst, buffer_u8, b ^ k);
    }

    buffer_seek(dst, buffer_seek_start, 0);
    var result = buffer_read(dst, buffer_string);

    buffer_delete(src);
    buffer_delete(dst);
    return result;
}