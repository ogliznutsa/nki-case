import LoginButton from "@/components/LoginButton";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <div className="z-10 max-w-5xl w-full items-center justify-center font-mono text-sm flex flex-col gap-8">
        <h1 className="text-4xl font-bold">NKI Application</h1>
        <p className="text-xl">Microsoft Entra ID B2B Authentication Demo</p>
        <LoginButton />
      </div>
    </main>
  );
}
