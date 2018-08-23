pragma solidity ^0.4.24;

contract Fluxing {
    function slip(bytes32,bytes32,int) public;
}

contract AdapterETH {
    Fluxing public vat;
    bytes32 public ilk;

    constructor(address vat_, bytes32 ilk_) public {
        vat = Fluxing(vat_);
        ilk = ilk_;
    }
    function join() payable public {
        require(msg.value >= 0);
        vat.slip(ilk, bytes32(msg.sender), int(msg.value));
    }
    function exit(uint wad) public {
        require(int(wad) >= 0);
        vat.slip(ilk, bytes32(msg.sender), -int(wad));
        address(msg.sender).transfer(wad);
    }
}
