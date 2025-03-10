"use client";

import React, { useEffect, useRef } from 'react';

// Access 3Dmol from window object since it's loaded via CDN
declare global {
  interface Window {
    $3Dmol: any;
  }
}

interface MoleculeViewerProps {
  smiles: string;
  width?: string;
  height?: string;
  style?: React.CSSProperties;
  className?: string;
}

export function MoleculeViewer({
  smiles,
  width = '100%',
  height = '400px',
  style,
  className,
}: MoleculeViewerProps) {
  const viewerRef = useRef<HTMLDivElement>(null);
  const viewerInstanceRef = useRef<any>(null);

  useEffect(() => {
    if (!viewerRef.current || !smiles || !window.$3Dmol) return;

    const viewer = window.$3Dmol.createViewer(viewerRef.current, {
      backgroundColor: 'black',
      id: `viewer-${Math.random()}`,
    });
    viewerInstanceRef.current = viewer;

    const mol = viewer.addModel(smiles, "smi");
    mol.setStyle({stick: {}});
    viewer.zoomTo();
    viewer.render();

    return () => {
      if (viewerInstanceRef.current) {
        viewerInstanceRef.current.clear();
      }
    };
  }, [smiles]);

  return (
    <div
      ref={viewerRef}
      style={{ width, height, ...style }}
      className={className}
    />
  );
}
