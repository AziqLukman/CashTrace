'use client';

import React, { useRef } from 'react';
import gsap from 'gsap';
import { useGSAP } from '@gsap/react';

interface SplashScreenProps {
    finishLoading?: () => void;
}

export default function SplashScreen({ finishLoading }: SplashScreenProps) {
    const containerRef = useRef<HTMLDivElement>(null);
    const overlayRef = useRef<SVGRectElement>(null);
    const loadingTextRef = useRef<HTMLDivElement>(null);

    useGSAP(() => {
        const tl = gsap.timeline({
            onComplete: () => {
                if (finishLoading) finishLoading();
            }
        });

        // Initial States
        gsap.set(overlayRef.current, { scaleY: 0, transformOrigin: 'bottom' });
        gsap.set(loadingTextRef.current, { opacity: 0, y: 10 });

        // Animation Sequence
        tl
            // 1. Reveal Text first (or simultaneous)
            .to(loadingTextRef.current, {
                opacity: 1,
                y: 0,
                duration: 0.5,
            })

            // 2. "Liquid" Fill Effect: Blue layer scales up to cover the white layer
            .to(overlayRef.current, {
                scaleY: 1,
                duration: 2.0,
                ease: "power1.inOut",
            })

            // 3. Smooth Exit
            .to(containerRef.current, {
                opacity: 0,
                duration: 0.8,
                delay: 0.2,
                ease: "power2.inOut",
            });

    }, { scope: containerRef });

    return (
        <div ref={containerRef} className="fixed inset-0 z-[9999] flex flex-col items-center justify-center bg-white dark:bg-slate-900">
            <div className="relative w-32 h-32 md:w-48 md:h-48">
                <svg
                    viewBox="0 0 24 24"
                    fill="none"
                    className="w-full h-full"
                >
                    {/* Defs for Masking if needed, but here we use layered paths */}
                    {/* We use two groups: Bottom (White) and Top (Blue) */}

                    {/* LAYER 1: BASE (WHITE Outline/Fill) - Representing the empty state */}
                    {/* Using gray-300 stroke for visibility on white background if fill is white */}
                    {/* The user wants "white side inside... becomes blue". So base is WHITE. */}
                    {/* We add a subtle stroke so it's visible against white background */}
                    <g className="text-gray-200" fill="currentColor">
                        <path d="M20 15C20.5523 15 21 14.5523 21 14C21 13.4477 20.5523 13 20 13C19.4477 13 19 13.4477 19 14C19 14.5523 19.4477 15 20 15Z" />
                        <path fillRule="evenodd" clipRule="evenodd" d="M16.775 0.985398C18.4919 0.460783 20.2821 1.55148 20.6033 3.3178L20.9362 5.14896C22.1346 5.54225 23 6.67006 23 8V10.7639C23.6137 11.3132 24 12.1115 24 13V15C24 15.8885 23.6137 16.6868 23 17.2361V20C23 21.6569 21.6569 23 20 23H4C2.34315 23 1 21.6569 1 20V8C1 6.51309 2.08174 5.27884 3.50118 5.04128L16.775 0.985398ZM21 16C21.5523 16 22 15.5523 22 15V13C22 12.4477 21.5523 12 21 12H18C17.4477 12 17 12.4477 17 13V15C17 15.5523 17.4477 16 18 16H21ZM21 18V20C21 20.5523 20.5523 21 20 21H4C3.44772 21 3 20.5523 3 20V8C3 7.44772 3.44772 7 4 7H20C20.55 7 20.9962 7.44396 21 7.99303L21 10H18C16.3431 10 15 11.3431 15 13V15C15 16.6569 16.3431 18 18 18H21ZM18.6954 3.60705L18.9412 5H10L17.4232 2.82301C17.9965 2.65104 18.5914 3.01769 18.6954 3.60705Z" />
                    </g>
                    {/* To make the white wallet visible on white screen, we need a stroke/outline logic. 
              The SVG provided is a FILL based SVG. 
              So we'll render it as Gray/Stroke first so the user sees the "bucket", 
              then fill it with Blue. 
          */}
                    <path
                        d="M16.775 0.985398C18.4919 0.460783 20.2821 1.55148 20.6033 3.3178L20.9362 5.14896C22.1346 5.54225 23 6.67006 23 8V10.7639C23.6137 11.3132 24 12.1115 24 13V15C24 15.8885 23.6137 16.6868 23 17.2361V20C23 21.6569 21.6569 23 20 23H4C2.34315 23 1 21.6569 1 20V8C1 6.51309 2.08174 5.27884 3.50118 5.04128L16.775 0.985398ZM21 16C21.5523 16 22 15.5523 22 15V13C22 12.4477 21.5523 12 21 12H18C17.4477 12 17 12.4477 17 13V15C17 15.5523 17.4477 16 18 16H21ZM21 18V20C21 20.5523 20.5523 21 20 21H4C3.44772 21 3 20.5523 3 20V8C3 7.44772 3.44772 7 4 7H20C20.55 7 20.9962 7.44396 21 7.99303L21 10H18C16.3431 10 15 11.3431 15 13V15C15 16.6569 16.3431 18 18 18H21ZM18.6954 3.60705L18.9412 5H10L17.4232 2.82301C17.9965 2.65104 18.5914 3.01769 18.6954 3.60705Z"
                        className="text-gray-300"
                        stroke="currentColor"
                        strokeWidth="0.5"
                        fill="none" // Outline only for the base
                    />


                    {/* LAYER 2: FILL (BLUE Liquid) */}
                    {/* We use a mask to clip the blue rectangle to the wallet shape */}
                    <mask id="fillMask">
                        <path fill="white" d="M20 15C20.5523 15 21 14.5523 21 14C21 13.4477 20.5523 13 20 13C19.4477 13 19 13.4477 19 14C19 14.5523 19.4477 15 20 15Z" />
                        <path fill="white" fillRule="evenodd" clipRule="evenodd" d="M16.775 0.985398C18.4919 0.460783 20.2821 1.55148 20.6033 3.3178L20.9362 5.14896C22.1346 5.54225 23 6.67006 23 8V10.7639C23.6137 11.3132 24 12.1115 24 13V15C24 15.8885 23.6137 16.6868 23 17.2361V20C23 21.6569 21.6569 23 20 23H4C2.34315 23 1 21.6569 1 20V8C1 6.51309 2.08174 5.27884 3.50118 5.04128L16.775 0.985398ZM21 16C21.5523 16 22 15.5523 22 15V13C22 12.4477 21.5523 12 21 12H18C17.4477 12 17 12.4477 17 13V15C17 15.5523 17.4477 16 18 16H21ZM21 18V20C21 20.5523 20.5523 21 20 21H4C3.44772 21 3 20.5523 3 20V8C3 7.44772 3.44772 7 4 7H20C20.55 7 20.9962 7.44396 21 7.99303L21 10H18C16.3431 10 15 11.3431 15 13V15C15 16.6569 16.3431 18 18 18H21ZM18.6954 3.60705L18.9412 5H10L17.4232 2.82301C17.9965 2.65104 18.5914 3.01769 18.6954 3.60705Z" />
                    </mask>

                    <g mask="url(#fillMask)">
                        {/* This blue rectangle scales up inside the mask */}
                        {/* We use #2463eb (brand blue) */}
                        <rect
                            ref={overlayRef}
                            x="0" y="0" width="24" height="24"
                            fill="#2463eb"
                        />
                    </g>


                </svg>
            </div>

            <div ref={loadingTextRef} className="mt-4 font-bold text-blue-600 tracking-widest text-lg uppercase">
                CashTrace
            </div>
        </div>
    );
}
