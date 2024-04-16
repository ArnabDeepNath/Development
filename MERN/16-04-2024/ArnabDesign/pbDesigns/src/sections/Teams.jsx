import React from 'react';
import TeamComponent from '../components/TeamComponent';

const Teams = () => {
  return (
    <div className="w-full h-[500px] bg-white p-8 flex space-x-4 lg:items-center lg:justify-center">
      <TeamComponent />
      <TeamComponent />
      <TeamComponent />
    </div>
  );
};

export default Teams;
