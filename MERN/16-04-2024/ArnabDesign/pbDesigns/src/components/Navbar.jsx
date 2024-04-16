import React from 'react';

const Navbar = () => {
  return (
    <div className="w-full bg-gray-100">
      <div className="flex space-x-4 justify-end py-8 mr-8 font-bold text-lg text-zinc-800">
        <a className="hover:text-white" href="">
          Home
        </a>
        <a className="hover:text-white" href="">
          Portfolio
        </a>
        <a className="hover:text-white" href="">
          Team
        </a>
        <a className="hover:text-white" href="">
          About Us
        </a>
      </div>
    </div>
  );
};

export default Navbar;
