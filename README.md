# 🧪 PHP Compatibility Checker

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
./check-compatibility.sh <path-to-code> <php-version> [more-versions...]
```

- `<path-to-code>`: file or directory to scan (e.g. `src`, `index.php`)
- `<php-version>`: PHP version to check against (e.g. `7.4`, `8.0`, `8.1`)

You can specify **multiple versions** to scan in one run.

---

## 📌 Examples

### ✅ Check a project directory for PHP 8.0 compatibility:

```
./check-compatibility.sh ./src 8.0
```

### ✅ Check multiple PHP versions (e.g. 7.4 and 8.1):

```
./check-compatibility.sh ./app 7.4 8.0 8.1
```

### ✅ Check a single file:

```
./check-compatibility.sh index.php 8.1
```

### ✅ Check multiple folders in one go:

```
./check-compatibility.sh "./app ./routes ./resources" 8.0
```

---

## 🔧 What’s Included

- `PHP_CodeSniffer`: Linter framework
- `PHPCompatibility`: Ruleset that detects version-based incompatibilities
- `dealerdirect/phpcodesniffer-composer-installer`: Auto-registers the custom ruleset

All installed locally — no system-wide changes.

---

## 💡 Tip for CI/CD

You can integrate this tool into your GitHub Actions or CI pipeline to fail builds when incompatible code is introduced. Ask in the Issues tab if you want an example workflow!

---

## 🐛 Found a Bug?

Please check or file issues with:

- [`PHPCompatibility`](https://github.com/PHPCompatibility/PHPCompatibility/issues)
- [`PHP_CodeSniffer`](https://github.com/squizlabs/PHP_CodeSniffer/issues)

---

## 📄 License

MIT License.