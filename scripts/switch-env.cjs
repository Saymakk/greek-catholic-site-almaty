const fs = require("node:fs");
const path = require("node:path");

const mode = process.argv[2];

if (!mode || !["local", "remote"].includes(mode)) {
  console.error("Usage: node scripts/switch-env.cjs <local|remote>");
  process.exit(1);
}

const root = process.cwd();
const source = path.join(root, `env.${mode}.example`);
const target = path.join(root, ".env.local");

if (!fs.existsSync(source)) {
  console.error(`Template not found: ${source}`);
  process.exit(1);
}

fs.copyFileSync(source, target);
console.log(`Switched to ${mode} mode. Updated ${target}`);
console.log("Fill real keys in .env.local if they are placeholders.");
