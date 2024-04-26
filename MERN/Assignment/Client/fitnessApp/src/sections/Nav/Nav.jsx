import React from 'react';

const Nav = () => {
  return (
    <div className="flex-col justify-end pr-8 h-[5rem] bg-transparent items-center">
      <div className="flex h-[100px] items-center">
        <div className="pr-[20rem] ml-2">Logo</div>
        <div className="flex justify-end space-x-8 w-full font-light pr-8">
          <a className="hover:font-bold" href="">
            Home
          </a>
          <a className="hover:font-bold" href="">
            About Us
          </a>
          <a className="hover:font-bold" href="">
            Workshops
          </a>
          <a className="hover:font-bold" href="">
            Contact Us
          </a>
        </div>
        <div className="flex justify-evenly space-x-2">
          <button className="border border-solid border-black rounded-3xl w-32 h-10 ">
            Register
          </button>
          <button className="border border-solid border-black w-32  h-10 rounded-3xl bg-black text-white hover:bg-transparent hover:text-black">
            Login
          </button>
        </div>
      </div>
      <div className="flex items-center justify-center">
        <div className="w-[90%] h-[1px] bg-zinc-400"></div>
      </div>
    </div>
  );
};

export default Nav;
