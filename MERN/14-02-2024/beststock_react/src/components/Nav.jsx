import { navLinks } from '../constants';

const Nav = () => {
  return (
    <div className="z-10 shadow-md absolute px-4 w-full h-[76px] flex-1 flex gap-4 justify-end items-center text-lg font-montserrat">
      {navLinks.map((item) => (
        <div key={item.label} className="hover:text-coral-red max-lg:hidden">
          <a href={item.href}> {item.label}</a>
        </div>
      ))}
    </div>
  );
};

export default Nav;
