import React from 'react';
import ConnectNowBtn from '../components/ConnectNowBtn/ConnectNowBtn';

const HeroSection = () => {
  return (
    <div className="w-full h-screen p-1 flex justify-between">
      <div className="textstructure mt-40 text-start px-12">
        <div className="masker">
          <h1 className="uppercase text-9xl tracking-tighter font-bold leading-[12vw] xl:leading-[5.5vw] ">
            Designs
          </h1>
          <h1 className="uppercase text-9xl tracking-tighter font-bold leading-[12vw] xl:leading-[5.5vw] ">
            Flow
          </h1>
          <h1 className="uppercase text-9xl tracking-tighter font-bold leading-[12vw] xl:leading-[5.5vw] ">
            Art
          </h1>
        </div>
        <div className="mt-4 flex justify-between">
          <h1 className="capitalize text-xl">
            Best in class design along with efficient and performance centric
            outputs.
          </h1>
        </div>
        <div className="w-full h-32 flex justify-between space-x-16 mt-8 p-4">
          <div className="w-full h-[1px] bg-zinc-400"></div>
          <ConnectNowBtn />
        </div>
      </div>
      <div className="w-[550px] h-[600px] flex items-center justify-center mt-8 mr-32">
        <img
          src="https://images.unsplash.com/photo-1541701494587-cb58502866ab?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
          alt=""
          className="w-[550px] h-[600px] object-cover rounded-3xl shadow-xl"
        />
      </div>
    </div>
  );
};

export default HeroSection;
