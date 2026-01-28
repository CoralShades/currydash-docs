// agent-browser-daemon.mjs
// Windows daemon starter for agent-browser
// Starts the daemon process directly via Node.js ESM import
// Usage: node scripts/agent-browser-daemon.mjs [session-name]

import { execSync } from 'child_process';
import { join } from 'path';
import { pathToFileURL } from 'url';

// Resolve the global agent-browser package path
const globalRoot = execSync('npm root -g', { encoding: 'utf8' }).trim();
const daemonPath = join(globalRoot, 'agent-browser', 'dist', 'daemon.js');
const daemonURL = pathToFileURL(daemonPath).href;

// Dynamic import from the resolved global path
const { startDaemon, setSession } = await import(daemonURL);

const session = process.argv[2] || process.env.AGENT_BROWSER_SESSION || 'default';
setSession(session);

try {
  await startDaemon();
} catch (err) {
  console.error('Daemon error:', err.message);
  process.exit(1);
}
