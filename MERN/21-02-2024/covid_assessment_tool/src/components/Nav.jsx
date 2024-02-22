import React from 'react';
import logo from '../assets/images/logo.png';
import { navLinks } from '../constants/index';
import Button from '../components/Button';
const Nav = () => {
  return (
    <nav className="z-10 absolute flex flex-row px-8 w-full bg-white">
      <img src={logo} alt="Logo" className=" relative w-[200px] h-full pt-2" />
      <div className="flex justify-center items-center w-full gap-8 text-slate-500">
        {navLinks.map((item) => (
          <div key={item.label}>
            <a className="hover:text-blue-500" href={item.href}>
              {item.label}
            </a>
          </div>
        ))}
      </div>
      <div className="flex flex-row py-8">
        <Button />
      </div>
    </nav>
  );
};

export default Nav;
