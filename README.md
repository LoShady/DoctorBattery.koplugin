<p align="center">
  <img src="images/logo.png" alt="Doctor Battery Logo" width="220">
</p>

<h1 align="center">Doctor Battery</h1>

<p align="center">
  Advanced battery diagnostics, system information and hardware analysis plugin for KOReader
</p>

<p align="center">
  <img src="https://img.shields.io/badge/KOReader-Compatible-4CAF50?style=for-the-badge" alt="KOReader Compatible">
  <img src="https://img.shields.io/badge/License-MIT-1976D2?style=for-the-badge" alt="MIT License">
  <img src="https://img.shields.io/badge/Languages-EN%20%7C%20IT%20%7C%20FR%20%7C%20DE%20%7C%20ES%20%7C%20PT-FF9800?style=for-the-badge" alt="Languages">
</p>

---

Doctor Battery is an advanced diagnostic plugin for KOReader that provides comprehensive battery, hardware and operating system information for your e-reader.

Instead of displaying only the battery percentage, Doctor Battery collects battery and hardware information exposed by the operating system and presents it through a clean, intuitive and easy-to-read interface.

From battery health monitoring to complete hardware analysis, Doctor Battery is designed to help users better understand their devices while continuously improving compatibility across Kindle, Kobo, Android and other Linux-based e-readers.

---

# ✨ Features

## 🔋 Battery Diagnostics

Doctor Battery provides a complete overview of your battery status.

Features include:

- 🔋 Battery percentage
- ❤️ Battery health estimation
- ⚡ Charging / Discharging status
- 🔄 Battery cycle count (when supported)
- 🌡️ Battery temperature
- 🔌 Battery voltage
- ⚙️ Battery current
- 🔋 Battery capacity (when available)
- 🔌 Charging source detection (USB / AC / Wireless, when supported)
- 📊 Detailed battery statistics
- 🩺 Automatic battery diagnostics
- ⚠️ Battery issue detection
- 💡 Health recommendations

---

## 🖥️ System Information

The new **System Information** section provides a detailed overview of your device.

Available categories include:

- 📱 Device Information
- ⚙️ Hardware Information
- 💾 Storage Information
- 🧠 Memory Information
- 🔋 Battery Information
- 🖥️ CPU Information
- 🌐 Network Information
- 📂 Operating System Information
- 📦 Environment Information

---

## 🔍 Hardware Scan

Doctor Battery includes a powerful **Hardware Scan** utility that searches common Linux system paths for battery- and hardware-related information.

The generated report helps identify where different devices expose battery information and is used to continuously improve compatibility across different e-reader platforms.

Current scan locations include:

```text
/sys/class/power_supply/
/sys/devices/
/proc/
/proc/device-tree/
/proc/sys/
/etc/
/dev/
/var/
/usr/
/mnt/
```

If your device is not fully supported, simply run **Hardware Scan**, generate the report and attach it to a GitHub Issue.

This is the fastest way to improve compatibility with additional Kindle, Kobo, Android and Linux-based devices.

---

## 🌍 Multi-language Support

Doctor Battery automatically follows the language currently configured in KOReader.

Currently available translations:

- 🇬🇧 English
- 🇮🇹 Italian
- 🇫🇷 French
- 🇩🇪 German
- 🇪🇸 Spanish
- 🇵🇹 Portuguese

Special thanks to **@CookieCaptainD** for contributing the Portuguese translation.

New translations are always welcome!

---

# 📥 Installation

1. Download the latest release.
2. Extract the archive.
3. Copy the `DoctorBattery.koplugin` folder into:

```text
koreader/plugins/
```

4. Restart KOReader.

---

# 😊 Emoji Support

Doctor Battery uses emoji icons throughout the interface to improve readability and make information easier to identify.

Some devices or fonts may not display emojis correctly.

For the best experience, install an emoji-compatible font.

Doctor Battery has been tested with **NotoEmoji**, which is currently the recommended font.

For installation instructions, please follow the KOAssistant guide:

https://github.com/zeeyado/koassistant.koplugin?tab=readme-ov-file#emoji-font-setup

---

# 📱 Compatibility

Doctor Battery is designed for KOReader.

Most information is obtained directly from the operating system.

Because every manufacturer exposes hardware information differently, some values may not be available on every device.

Doctor Battery has been designed to gracefully handle unsupported fields whenever possible.

Compatibility will continue to improve as more Hardware Scan reports are collected from the community.

---

# 📸 Screenshots

## 🏠 Main Menu

Quick access to all Doctor Battery features.

![Main Menu](screenshots/MAIN.png)

---

## 🔋 Battery Status

Displays battery charge, charging status and general battery information.

![Battery Status](screenshots/B.S.png)

---

## 🩺 Battery Diagnosis

Automatic battery analysis with detected issues and health recommendations.

![Battery Diagnosis](screenshots/D.D.png)

---

## ⚡ Electrical Parameters

Displays voltage, current, temperature and other electrical measurements.

![Electrical Parameters](screenshots/E.P.png)

---

## 🖥️ System Information

Comprehensive hardware and operating system information.

![System Information](screenshots/SYSTEM.png)

---


# 🤝 Contributing

Bug reports, feature requests and pull requests are always welcome.

If Doctor Battery doesn't correctly detect battery or hardware information on your device, please open a GitHub Issue and attach the generated **Hardware Scan** report.

Providing the scan report is the fastest and easiest way to improve compatibility with your device.

---

# 📄 License

Doctor Battery is released under the **MIT License**.
