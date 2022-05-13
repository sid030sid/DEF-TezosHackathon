const EQT = artifacts.require("EQT");

module.exports = deployer => {
  deployer.deploy(EQT, 0);
};
