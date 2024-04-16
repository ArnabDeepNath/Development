import './App.css';
import AboutUs from './components/AboutUs';
import HeroSection from './components/HeroSection/';
import Navbar from './components/Navbar';
import PortfolioSection from './components/PortfolioSection';
import ScrollingHeader from './components/ScrollingHeader';
import Teams from './sections/Teams';

import Footer from './components/Footer';

export default function App() {
  return (
    <div className="w-full h-full bg-zinc-900">
      <Navbar />
      <HeroSection />
      <ScrollingHeader />
      <Teams />
      <PortfolioSection />
      <AboutUs />
      <Footer />
    </div>
  );
}
