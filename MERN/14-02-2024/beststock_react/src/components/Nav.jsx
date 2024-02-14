import { navLinks } from '../constants';

const Nav = () => {
  return (
    <header className="p-10 ">
      <nav className="flex justify-between items-center max-container">
        <ul className="flex justify-start gap-10">
          {navLinks.map((item) => (
            <li
              className="font-monsterrat leading-normal text-lg text-slate-gray hover:text-gray-400 cursor-pointer"
              key={item.label}>
              {item.label}
            </li>
          ))}
        </ul>
      </nav>
    </header>
  );
};

export default Nav;
