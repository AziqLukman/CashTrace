'use client';

import { useEffect, useState } from 'react';
import { usePathname } from 'next/navigation';
import Sidebar from './components/Sidebar';
import SplashScreen from './components/SplashScreen';

export default function ClientLayout({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Only load user theme if on authenticated pages
    const isAuthPage = pathname === '/login' || pathname === '/register' || pathname === '/forgot-password';

    if (isAuthPage) {
      // Always light mode on auth pages
      document.documentElement.classList.remove('dark');
      return;
    }

    // Load theme per-user
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      try {
        const parsedUser = JSON.parse(storedUser);
        const userId = parsedUser.id || parsedUser._id;
        const savedTheme = localStorage.getItem(`theme_${userId}`);
        if (savedTheme === 'dark') {
          document.documentElement.classList.add('dark');
        } else {
          document.documentElement.classList.remove('dark');
        }
      } catch (e) {
        document.documentElement.classList.remove('dark');
      }
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, [pathname]);

  if (isLoading) {
    return <SplashScreen finishLoading={() => setIsLoading(false)} />;
  }

  const isAuthPage = pathname === '/login' || pathname === '/register';

  if (isAuthPage) {
    return <>{children}</>;
  }

  return (
    <div className="flex min-h-screen w-full bg-background-light dark:bg-background-dark text-slate-900 dark:text-white">
      <Sidebar />
      <main className="flex-1 flex flex-col pt-16 lg:pt-0 min-h-screen transition-all duration-300">
        {children}
      </main>
    </div>
  );
}
