import React, { useEffect, useState } from 'react';
import './Navbar.css';

const Navbar = () => {
  const [isSticky, setIsSticky] = useState(false);
  const [opacity, setOpacity] = useState(1);

  useEffect(() => {
    const handleScroll = () => {
      setIsSticky(window.pageYOffset > 0);
      setOpacity(1 - window.pageYOffset / 600); // Adjust 200 based on how quickly you want the opacity to decrease
    };

    window.addEventListener('scroll', handleScroll);

    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);

  return (
    <div
      className={`navbar ${isSticky ? 'sticky' : ''}`}
      style={{ opacity: opacity }}>
      <div className="w-full px-4 py-8 bg-gray-50 flex justify-end">
        <div className="links flex gap-10 items-center">
          {['Service', 'Team', 'Portfolio', 'About us', 'Connect Now'].map(
            (item, index) => (
              <a
                key={index}
                className={`capitalize text-lg font-light font-[lato] cursor-pointer  ${
                  index === 4 &&
                  'ml-32 border-solid border-2 border-zinc-400 rounded-3xl px-8 py-2 hover:text-white hover:bg-zinc-800'
                }`}
                style={{ position: 'relative' }}>
                <h1>{item}</h1>
                <span className="bg-zinc-400" />
              </a>
            ),
          )}
        </div>
      </div>
    </div>
  );
};

export default Navbar;
