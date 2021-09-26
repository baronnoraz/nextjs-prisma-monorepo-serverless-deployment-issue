import prisma from '@example/prisma';
import type { User } from '@prisma/client';

export type PartialUser = Pick<User, 'id' | 'name' | 'email'>;

export const getUsers = async (): Promise<PartialUser[]> => {
  const users: User[] = await prisma.user.findMany();

  return users.map(user => {
    return {
      id: user.id,
      name: user.name,
      email: user.email
    }
  });
}