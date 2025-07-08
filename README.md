# 🧪 PHP Compatibility Checker

[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A simple command-line tool to check your PHP code for compatibility with different PHP versions using:

- ✅ [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)
- ✅ [PHPCompatibility](https://github.com/PHPCompatibility/PHPCompatibility)

No global installs needed — all dependencies are handled locally via Composer.

---

## ⚙️ Setup

1. Clone this repository:

```
git clone https://github.com/yourname/php-compat-checker.git
cd php-compat-checker
```

2. Install dependencies:

```
composer install
```

3. Make the script executable:

```
chmod +x check-compatibility.sh
```

---

## 🚀 Usage

```
./check-compatibility.sh [-r] [--log=output.log] [--exclude=pattern] <path> <php-version> [more-versions...]
```

- `-r`: recursively scan directories
- `--log=output.log`: save output to a file
- `--exclude=pattern`: exclude files matching pattern (can be used multiple times)

---

## 📌 Examples

### ✅ Check a project directory for PHP 8.0 compatibility:

```
./check-compatibility.sh ./src 8.0
```

### ✅ Check multiple PHP versions:

```
./check-compatibility.sh ./app 7.4 8.0 8.1
```

### ✅ Check a single file:

```
./check-compatibility.sh index.php 8.1
```

### ✅ Recursive scan with log and exclusions:

```
./check-compatibility.sh -r --log=compat.log --exclude="vendor" --exclude="tests" ./src 7.4 8.0
```

---

## 🔧 What’s Included

- `PHP_CodeSniffer`: Linter framework (BSD-3-Clause)
- `PHPCompatibility`: Version ruleset (GPL-3.0-or-later)
- Local composer install only — no global dependencies required

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
