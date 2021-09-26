import type { PartialUser } from '../services/userService';
import type { NextPage } from 'next';
import Head from 'next/head';
import Image from 'next/image';
import { getUsers } from '../services/userService';
import styles from '../styles/Home.module.css';

const Home: NextPage<{users: PartialUser[]}> = (props: {users: PartialUser[]}) => {

  const { users } = props;

  return (
    <div className={styles.container}>
      <Head>
        <title>NextJS + Prisma + Monorepo Example</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          NextJS + Prisma + Monorepo Example
        </h1>

        <ul>
          {users && users.map((user: PartialUser) => {
            return (
              <li key={user.id}>{user.name} ({user.email})</li>
            )
          })}
        </ul>
      </main>

      <footer className={styles.footer}>
        <a
          href="https://vercel.com?utm_source=create-next-app&utm_medium=default-template&utm_campaign=create-next-app"
          target="_blank"
          rel="noopener noreferrer"
        >
          Powered by{' '}
          <span className={styles.logo}>
            <Image src="/vercel.svg" alt="Vercel Logo" width={72} height={16} />
          </span>
        </a>
      </footer>
    </div>
  )
}

export const getServerSideProps = async () => {

  const users = await getUsers();
  return {
    props: {
      users
    }
  }
}

export default Home;
