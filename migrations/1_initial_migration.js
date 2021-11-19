const ERC721 = artifacts.require("EinsteinNFT");
const Web3 = require("web3");
const { deployProxy, upgradeProxy } = require("@openzeppelin/truffle-upgrades");

module.exports = async function (deployer, network) {
    if (network === "development") {
        // await deployer.deploy(ERC721);
        // let EinsteinNFT = await deployProxy(ERC721, [], {
        //     deployer,
        //     initializer: "initialize",
        // });
        // await deployer.deploy(ERC721);
        try {
            await deployer.deploy(ERC721);
            let contract = await deployProxy(ERC721, [], {
                deployer,
                initializer: "initialize",
            });
            // console.log(contract.address);
            contract.mint("0xa6510E349be7786200AC9eDC6443D09FE486Cb40", "abc.json");
            console.log(contract.tokenURI(1));
        } catch (e) {
            console.log(e);
        }
    }
    if (network === "mumbai") {
        await deployer.deploy(ERC721);

        // intailize: intiaizlizer function name
        let contract = await deployProxy(ERC721, [], { deployer, initializer: "initialize" });
        // await upgradeProxy(PROXY_ADDRESS, ERC721, { deployer });
    }
    if (network === "maticmainnet") {
        await deployer.deploy(ERC721);

        // intailize: intiaizlizer function name
        let contract = await deployProxy(ERC721, [], { deployer, initializer: "initialize" });
        // await upgradeProxy(PROXY_ADDRESS, ERC721, { deployer });
    }
};
