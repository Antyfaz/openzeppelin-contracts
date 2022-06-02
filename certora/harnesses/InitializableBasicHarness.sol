// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../munged/proxy/utils/Initializable.sol";

contract InitializableBasicHarness is Initializable {

    uint256 public val;
    uint256 public a;
    uint256 public b;

    modifier version1() {
        require(_initialized == 1);
        _;
    }

    modifier versionN(uint8 n) {
        require(_initialized == n);
        _;
    }

    function initialize(uint256 _val, uint256 _a, uint256 _b) public initializer {
        a = _a;
        b = _b;
        val = _val;
    }

    function reinitialize(uint256 _val, uint256 _a, uint256 _b, uint8 n) public reinitializer(n) {
        a = _a;
        b = _b;
        val = _val;
    }

    // Versionede return functions for testing

    function returnsV1() public view version1 returns(uint256) {
        return val/2;
    }

    function returnsVN(uint8 n) public view versionN(n) returns(uint256) {
        return val/(n+1);
    }
    
    function returnsAV1() public view version1 returns(uint256) {
        return a/2;
    }

    function returnsAVN(uint8 n) public view versionN(n) returns(uint256) {
        return a/(n+1);
    }

    function returnsBV1() public view version1 returns(uint256) {
        return b/2;
    }

    function returnsBVN(uint8 n) public view versionN(n) returns(uint256) {
        return b/(n+1);
    }

    // Harness //
    function initialized() public view returns(uint8) {
        return _initialized;
    }

    function initializing() public view returns(bool) {
        return _initializing;
    }

    function thisIsContract() public view returns(bool) {
        return !Address.isContract(address(this));
    }
    
}
