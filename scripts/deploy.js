const hre = require("hardhat");

async function main() {
  try {
    const initBalance = 1;
    const Assessment = await hre.ethers.getContractFactory("Assessment");
    const assessment = await Assessment.deploy(initBalance);
    await assessment.deployed();

    console.log(`A contract with balance of ${initBalance} eth deployed to ${assessment.address}`);
  } catch (error) {
    console.error(error);
    process.exitCode = 1;
  }
}

main();

