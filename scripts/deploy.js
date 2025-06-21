const hre = require("hardhat");

async function main() {
  const TokenAuditTrail = await hre.ethers.getContractFactory("TokenAuditTrail");
  const contract = await TokenAuditTrail.deploy();

  await contract.deployed();

  console.log(`TokenAuditTrail deployed to: ${contract.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Deployment failed:", error);
    process.exit(1);
  });
