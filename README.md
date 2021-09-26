# nextjs-prisma-monorepo-serverless-deployment-issue
A minimal repo demonstrating a serverless deployment issue in a NextJS + Prisma monorepo.

# Versions
```shell
# ~/git/example
node -v
v14.17.4

npm -v
7.20.5
```

# Getting Started
Checkout the code from 
```shell
git clone git@github.com:baronnoraz/nextjs-prisma-monorepo-serverless-deployment-issue.git example
```

To run the project locally
1. Start the docker container, from `db/docker` run `docker-compose up`
2. From the root of the project run `npx -w db/prisma prisma generate`
3. From the root of the project run `npm -w apps/client run dev`

# Docker 
`example/db/docker`

The Docker container is used for local development. WHen deploying the applications to AWS you need to 
create an RDS instance and manually run `db/docker/init/001-DDL.sql` to create the tables and
`db/docker/init/002-DATA.sql` for some example data.

# Prisma
`example/db/prisma`

A wrapper around the Prisma library to standardize what is used by the front-end applications in `apps/`.

To generate the `schema.prisma` file and engine binaries run the following at the root of the project. 

```shell
# ~/git/example/
npx -w db/prisma prisma generate
```

# Client App
`example/apps/client`

The Client App is a NextJS app created using `npx create-next-app --typescript`.
`node_modules` and `package-lock.json` were removed because `npm v7` workspaces will be used.
The `pages` and `styles` folders were moved to the `src` folder.

After generating the `schema.prisma` file, you can run the client app using

```shell
# ~/git/example
npm -w apps/client run dev
```

# Serverless

Before deploying to AWS, you must configure your credentials.

```dotenv
# example/apps/client/.env

# serverless-deployer
AWS_ACCESS_KEY_ID = <YOUR_ACCESS_KEY_ID>
AWS_SECRET_ACCESS_KEY = <YOUR_SECRET_ACCESS_KEY>

# Amazon
# Add your AWS configuration here
DATABASE_URL = mysql://user:password@domain:port/db
```

```dotenv
# example/db/prisma/.env

# Amazon
# Add your AWS configuration here
DATABASE_URL = mysql://user:password@domain:port/db
```

Generate the Prisma schema and binary, then deploy the app using serverless.
```shell
# ~/git/example
npx -w db/prisma prisma generate
npx -w apps/client serverless
```

# Serverless Deployment Error
```shell
  error:
  Error: Command failed with exit code 1: ../../node_modules/.bin/next build
(node:29546) [DEP_WEBPACK_CHUNK_HAS_ENTRY_MODULE] DeprecationWarning: Chunk.hasEntryModule: Use new ChunkGraph API
(Use `node --trace-deprecation ...` to show where the warning was created)
warn  - Compiled with warnings

../../node_modules/next/dist/server/load-components.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/load-components.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/load-components.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/require.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/require.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/require.js
Critical dependency: the request of a dependency is an expression


> Build error occurred
Error: ENOENT: no such file or directory, open '/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/schema.prisma'
    at Object.openSync (fs.js:498:3)
    at Object.readFileSync (fs.js:394:35)
    at new LibraryEngine (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/569.js:25128:42)
    at PrismaClient.getEngine (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/569.js:37747:16)
    at new PrismaClient (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/569.js:37716:29)
    at Module.1074 (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:26:16)
    at __webpack_require__ (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:465:43)
    at Module.4263 (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:154:23)
    at __webpack_require__ (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:465:43)
    at /Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:485:96 {
  type: 'Error',
  errno: -2,
  syscall: 'open',
  code: 'ENOENT',
  path: '/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/schema.prisma',
  clientVersion: '3.1.1'
}
info  - Loaded env from /Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.env
info  - Using webpack 5. Reason: Enabled by default https://nextjs.org/docs/messages/webpack5
info  - Checking validity of types...
info  - Creating an optimized production build...
info  - Collecting page data...
    at makeError (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/node_modules/execa/lib/error.js:60:11)
    at handlePromise (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/node_modules/execa/index.js:118:26)
    at processTicksAndRejections (internal/process/task_queues.js:95:5)
    at async Builder.build (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/node_modules/@sls-next/lambda-at-edge/dist/build.js:362:13) {
  shortMessage: 'Command failed with exit code 1: ../../node_modules/.bin/next build',
  command: '../../node_modules/.bin/next build',
  escapedCommand: '"../../node_modules/.bin/next" build',
  exitCode: 1,
  signal: undefined,
  signalDescription: undefined,
  stdout: 'info  - Loaded env from /Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.env\n' +
    'info  - Using webpack 5. Reason: Enabled by default https://nextjs.org/docs/messages/webpack5\n' +
    'info  - Checking validity of types...\n' +
    'info  - Creating an optimized production build...\n' +
    'info  - Collecting page data...',
  stderr: '(node:29546) [DEP_WEBPACK_CHUNK_HAS_ENTRY_MODULE] DeprecationWarning: Chunk.hasEntryModule: Use new ChunkGraph API\n' +
    '(Use `node --trace-deprecation ...` to show where the warning was created)\n' +
    'warn  - Compiled with warnings\n' +
    '\n' +
    '../../node_modules/next/dist/server/load-components.js\n' +
    'Critical dependency: the request of a dependency is an expression\n' +
    '\n' +
    '../../node_modules/next/dist/server/load-components.js\n' +
    'Critical dependency: the request of a dependency is an expression\n' +
    '\n' +
    '../../node_modules/next/dist/server/load-components.js\n' +
    'Critical dependency: the request of a dependency is an expression\n' +
    '\n' +
    '../../node_modules/next/dist/server/require.js\n' +
    'Critical dependency: the request of a dependency is an expression\n' +
    '\n' +
    '../../node_modules/next/dist/server/require.js\n' +
    'Critical dependency: the request of a dependency is an expression\n' +
    '\n' +
    '../../node_modules/next/dist/server/require.js\n' +
    'Critical dependency: the request of a dependency is an expression\n' +
    '\n' +
    '\n' +
    '> Build error occurred\n' +
    "Error: ENOENT: no such file or directory, open '/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/schema.prisma'\n" +
    '    at Object.openSync (fs.js:498:3)\n' +
    '    at Object.readFileSync (fs.js:394:35)\n' +
    '    at new LibraryEngine (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/569.js:25128:42)\n' +
    '    at PrismaClient.getEngine (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/569.js:37747:16)\n' +
    '    at new PrismaClient (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/569.js:37716:29)\n' +
    '    at Module.1074 (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:26:16)\n' +
    '    at __webpack_require__ (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:465:43)\n' +
    '    at Module.4263 (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:154:23)\n' +
    '    at __webpack_require__ (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:465:43)\n' +
    '    at /Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:485:96 {\n' +
    "  type: 'Error',\n" +
    '  errno: -2,\n' +
    "  syscall: 'open',\n" +
    "  code: 'ENOENT',\n" +
    "  path: '/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/schema.prisma',\n" +
    "  clientVersion: '3.1.1'\n" +
    '}',
  failed: true,
  timedOut: false,
  isCanceled: false,
  killed: false
}

  17s › exampleApp › Error: Command failed with exit code 1: ../../node_modules/.bin/next build
(node:29546) [DEP_WEBPACK_CHUNK_HAS_ENTRY_MODULE] DeprecationWarning: Chunk.hasEntryModule: Use new ChunkGraph API
(Use `node --trace-deprecation ...` to show where the warning was created)
warn  - Compiled with warnings

../../node_modules/next/dist/server/load-components.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/load-components.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/load-components.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/require.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/require.js
Critical dependency: the request of a dependency is an expression

../../node_modules/next/dist/server/require.js
Critical dependency: the request of a dependency is an expression


> Build error occurred
Error: ENOENT: no such file or directory, open '/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/schema.prisma'
    at Object.openSync (fs.js:498:3)
    at Object.readFileSync (fs.js:394:35)
    at new LibraryEngine (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/569.js:25128:42)
    at PrismaClient.getEngine (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/569.js:37747:16)
    at new PrismaClient (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/569.js:37716:29)
    at Module.1074 (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:26:16)
    at __webpack_require__ (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:465:43)
    at Module.4263 (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:154:23)
    at __webpack_require__ (/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:465:43)
    at /Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/pages/index.js:485:96 {
  type: 'Error',
  errno: -2,
  syscall: 'open',
  code: 'ENOENT',
  path: '/Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.next/serverless/chunks/schema.prisma',
  clientVersion: '3.1.1'
}
info  - Loaded env from /Users/nbuckner/git/nextjs-prisma-monorepo-serverless-deployment-issue/apps/client/.env
info  - Using webpack 5. Reason: Enabled by default https://nextjs.org/docs/messages/webpack5
info  - Checking validity of types...
info  - Creating an optimized production build...
info  - Collecting page data...
```

Previously, the following `postBuildCommands` would copy `schema.prisma` and the query engine (`query-engine-rhel-*`) to the 
appropriate location in the deployment folders.  But with the newer versions, I know how to hook into the build in a way that
allows me to copy the files to the location that the Prisma Client is expecting.

```yaml
postBuildCommands:
  - PDIR=../../node_modules/.prisma/client/;
    LDIR=.serverless_nextjs/api-lambda/;
    TDIR="$LDIR"chunks/;
    if [ "$(ls -A $LDIR)" ]; then
    mkdir -p $TDIR;
    cp "$PDIR"query-engine-rhel-* $TDIR;
    cp "$PDIR"schema.prisma $TDIR;
    fi;
  - PDIR=../../node_modules/.prisma/client/;
    LDIR=.serverless_nextjs/default-lambda/;
    TDIR="$LDIR"chunks/;
    if [ "$(ls -A $LDIR)" ]; then
    mkdir -p $TDIR;
    cp "$PDIR"query-engine-rhel-* $TDIR;
    cp "$PDIR"schema.prisma $TDIR;
    fi;
```