// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import {
    CFAv1Library
} from "@superfluid-finance/ethereum-contracts/contracts/apps/CFAv1Library.sol";

import "@openzeppelin/contracts/ownership/Ownable.sol";


contract Streamer is Ownable {

    using CFAv1Library for CFAv1Library.InitData;

    //initialize cfaV1 variable
    CFAv1Library.InitData public cfaV1;
    
    constructor(
        ISuperfluid host
    ) {
    
    //initialize InitData struct, and set equal to cfaV1
    cfaV1 = CFAv1Library.InitData(
        host,
        //here, we are deriving the address of the CFA using the host contract
        IConstantFlowAgreementV1(
            address(host.getAgreementClass(
                    keccak256("org.superfluid-finance.agreements.ConstantFlowAgreement.v1")
                ))
            )
        );

        deposit();
    }

    // flow rate

    // token address

    //

    function deposit () public payable onlyOwner {
        require(msg.value > 0 ether);
        
    }

    function withdraw () public {

    }

    function openStream (address receiver, address token, int96 flowRate) private {
        cfaV1.createFlow(receiver, token, flowRate);
    }

    function editStream (address receiver, address token, int96 flowRate) public {
        cfaV1.updateFlow(receiver, token, flowRate);
    }

    function closeStream (address sender, address receiver, address token) public {
        cfaV1.deleteFlow(sender, receiver, token);
    }


}