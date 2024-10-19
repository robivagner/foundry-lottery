// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {Raffle} from "src/Raffle.sol";
import {DeployRaffle} from "script/DeployRaffle.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "script/Interactions.s.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {VRFCoordinatorV2_5Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";
import {LinkToken} from "test/mocks/LinkToken.sol";

contract InteractionsTest is Test {
    VRFCoordinatorV2_5Mock vrfMock;

    function setUp() external {
        vrfMock = new VRFCoordinatorV2_5Mock(0, 0, 0);
    }

    function testCreateSubscription() public {
        // Arrange
        CreateSubscription createSubscription = new CreateSubscription();

        // Act
        (uint256 subId, address vrfCoordinator) = createSubscription.createSubscription(address(vrfMock), address(this));

        // Assert
        assert(subId > 0);
        assert(vrfCoordinator == address(vrfMock));
    }

    function testCreateSubscriptionUsingConfig() public {
        // Arrange
        CreateSubscription createSubscription = new CreateSubscription();

        // Act
        (uint256 subId, ) = createSubscription.createSubscriptionUsingConfig();

        // Assert
        assert(subId > 0);
    }

    function testAddConsumer() public {
        // Arrange
        AddConsumer addConsumer = new AddConsumer();
        address consumer = address(this);
        uint256 subId;
        subId = vrfMock.createSubscription();

        // Act
        addConsumer.addConsumer(consumer, address(vrfMock), subId, address(this));

        // Assert
        assert(vrfMock.consumerIsAdded(subId, consumer) == true);
    }

    function testFundSubscription() public {
        // Arrange
        FundSubscription fundSubscription = new FundSubscription();
        uint256 subId;
        subId = vrfMock.createSubscription();
        LinkToken link = new LinkToken();

        // Act
        fundSubscription.fundSubscription(address(vrfMock), subId, address(link), address(this));
        (uint96 balance,,,,) = vrfMock.getSubscription(subId);

        // Assert
        assert(balance == 3 ether * 100);
    }
}