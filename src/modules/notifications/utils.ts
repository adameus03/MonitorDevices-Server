export function uint8ArrayToBase64Url(uint8Array: Uint8Array): string {
    // Convert Uint8Array to a binary string
    let binaryString = '';
    for (let i = 0; i < uint8Array.length; i++) {
        binaryString += String.fromCharCode(uint8Array[i]);
    }

    // Encode the binary string to base64
    const base64String = btoa(binaryString);

    // Construct the base64 data URL
    const base64Url = `data:image/jpeg;base64,${base64String}`;

    return base64Url;
}

// export function videoToBase64Url(videoPath: string): string {

// }