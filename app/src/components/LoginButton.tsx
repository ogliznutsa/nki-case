"use client";

import { signIn, signOut, useSession } from "next-auth/react";

export default function LoginButton() {
  const { data: session } = useSession();

  if (session) {
    return (
      <div className="flex flex-col items-center gap-4">
        <p>Signed in as {session.user?.email}</p>
        <p>Name: {session.user?.name}</p>
        <button
          onClick={() => signOut()}
          className="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600"
        >
          Sign out
        </button>
      </div>
    );
  }

  return (
    <button
      onClick={() => signIn("microsoft-entra-id")}
      className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
    >
      Sign in
    </button>
  );
}
