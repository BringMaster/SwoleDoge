
const SafeMath = artifacts.require("SafeMath");
const SOGEERC20Token = artifacts.require("SOGEERC20Token");

module.exports = function (deployer) {
  deployer.deploy(SafeMath);
  deployer.deploy(SOGEERC20Token, "Swole Doge", "SOGE", 18, "100000000000000000000000000000", "0x2126EC768915d5A539Fb7463EB6450DBa68fd759", "0x2126EC768915d5A539Fb7463EB6450DBa68fd759");
};
