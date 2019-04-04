# Ipa-Install

This demo is about installing `.ipa` files within the app.

### Why

There are many ways to install `.ipa` files that are signed by enterprise certificate. 

One of the most popular way is using a self-host server to hold `.ipa` files and letting the system to download it with a `.plist` file.

It's nice. But when it comes to a large `.ipa` file and the user is using cellular network, the user has to wait.

### How

To bypass apple's limitation, we can download `.ipa` file on our own and create a http server to host the `.ipa` file for installation.

This demo use [Tiercel](https://github.com/Danie1s/Tiercel) to download file and [Swifter](https://github.com/httpswift/swifter) to start a http server.

### About demo

This demo contains no visible ui and it uses log output to show the changes.

### Ref

- [DownloadAndInstallIpa](https://github.com/lovelyjune/DownloadAndInstallIpa)

