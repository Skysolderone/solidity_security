import { ethers } from 'hardhat';
import { InsecureEhterVault } from '../typechain-types';
async function deploy() {
  const ETHV = await ethers.getContractFactory('InsecureEhterVault');
  const et = await ETHV.deploy();
  await et.waitForDeployment();
  console.log(`${et.target}`);
  const ETHV2 = await ethers.getContractFactory('Attack');
  const et2 = await ETHV2.deploy(et.target);
  await et2.waitForDeployment();
  console.log(`${et2.target}`);
}
async function main() {
  //   await deploy();
  const ev = await ethers.getContractAt(
    'InsecureEhterVault',
    '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0'
  );
  const [owner, a1, a2] = await ethers.getSigners();
  console.log(`${a1.address}`);
  const b1 = await ev.getUserBalance(a1.address);
  const b2 = await ev.getUserBalance(a2.address);
  console.log(`b1${b1} b2${b2}`);
}

main().catch((e) => {
  console.log(e);
  process.exitCode = 1;
});
