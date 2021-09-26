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
