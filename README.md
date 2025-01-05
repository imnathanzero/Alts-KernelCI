<div align='center'>

<h1>Build Your Kernel with Github Action</h1>

![License](https://img.shields.io/static/v1?label=License&message=BY-NC-SA&logo=creativecommons&color=green)
![Language](https://img.shields.io/github/languages/top/shenprjkt/Alts-KernelCI)
![Issues](https://img.shields.io/github/issues/shenprjkt/Alts-KernelCI)
![Pull Requests](https://img.shields.io/github/issues-pr/shenprjkt/Alts-KernelCI)
<br/>

This Github Action helps you build kernels. It reads multiple kernel sources from a configuration file and builds them using different toolchains. Additionally, it supports patching the kernel with KernelSU and uploading the built kernel image.
<br/>

---

**[<kbd> <br/>  Configure  <br/> </kbd>](#configuration)**
**[<kbd> <br/>  Quick Start  <br/> </kbd>](#how-to-use)**
**[<kbd> <br/>  Local testing  <br/> </kbd>](#local-testing)**

---

</div>

# Github Action

This action contains three jobs: `Setup-Env`, `Build-Kernel`, `Post-Update`.

`Setup-Env` stage is the Dependency Installation stage.

`Build-Kernel` stage is the stage of building the kernel and packaging the kernel with AnyKernel and uploading it to the destination group like 'Telegram'/other download mirrors (The Upload stage only supports uploading to Telegram at this time "Upload Mirror in progress").

`Post-Update` stage is the stage where this will create an auto post update to the destination channel with support (banner, download link, and credit as appreciation).

## Post-Update Feature

<img src="./.assets/img/Post.jpg" width="240" height="540" alt="banner" />

## Trigger

| Event name        | Description  |
| ----------------- | ------------ |
| workflow_dispatch | Manually run |
