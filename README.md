# Google Colaboratory RDP Server
This is an RDP Server to connect to the Google Colaboratory machine(?) via RDP to make it easier to use.
You can use it anytime as long as it isn't deprecated yet because of google itself.

## Usage

<a href="#" target="_parent\"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>

1. Click the Run cell button (Play emoji like thingy).
2. Input your username and password there<br />
2.1. Wait for the RDP Server installing.
3. Just follow the rest of it okay.
4. Go to https://remotedesktop.google.com/headless,<br />
4.1. Click Begin > Next > Authorize > Select your google account > Copy Debian Linux > Start Over, then close the tab,<br />
4.2. Paste the command that you've copied in the terminal(?) then press enter,<br />
4.3. Enter a PIN at least six digits and then enter the same PIN again.
5. Wait for `Package upgrade has completed` show up.
6. Go to https://remotedesktop.google.com/access,<br/>
6.1. Select your remote device(s).
7. AND BOOM YOU'RE CONNECTED
8. You need to repeat those step if the machine disconnected.


## Script To At Least Keep The Machine(?) Online For 12 Hours

To use it just open the developer tools by press `F12` or `Ctrl + Alt + I` on your Keyboard and open the console, copy the script and paste it there then press enter.

```js
function ConnectButton(){
    console.log("Connect pushed"); 
    document.querySelector("#top-toolbar > colab-connect-button").shadowRoot.querySelector("#connect").click() 
}
setInterval(ConnectButton,60000);
```

