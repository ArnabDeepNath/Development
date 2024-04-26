import React from 'react';
import './Hero.css';
const Hero = () => {
  return (
    <div className="p-28 flex-col justify-between w-full">
      <div>
        <h1 className="heroHeader text-[150px] font-extrabold leading-none">
          Fitness Fusion
        </h1>
      </div>
      <div className="flex-col">
        <h2 className="font-light text-[25px] leading-[32px] text-gray-600 w-[500px] mt-8 mb-8">
          Fitness is not just about looking good, it's about feeling good from
          the inside out. Don't count the days, make the days count
        </h2>
        <button className="border border-solid border-zinc-400 rounded-3xl h-[80px] w-[52px]">
          <a className="font-bold capitalize" href="">
            Join Workshop
          </a>
        </button>
        <div className="flex flex-row justify-between w-full space-x-8 mt-8">
          <div className="text-lg">
            <h1 className="font-bold">90+</h1>
            <h2 className="font-light">Professional Trainers</h2>
          </div>
          <div className="text-lg">
            <h1 className="font-bold">15k+</h1>
            <h2 className="font-light">Happy Customers</h2>
          </div>
          <div className="text-lg">
            <h1 className="font-bold">75+</h1>
            <h2 className="font-light">Fitness Workshops</h2>
          </div>
          <img
            className="w-full h-full pb-4"
            src="https://png.pngtree.com/png-clipart/20231018/original/pngtree-becoming-a-personal-trainer-transparent-background-png-image_13354511.png"
            alt="Hero_Image"
          />
        </div>
      </div>
    </div>
  );
};

export default Hero;
