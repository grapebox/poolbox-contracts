// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library Sweep {

	function sweep(
		address recipient,
		address erc20,
		uint256 transferAmount
	) public {
		require(recipient != address(0), "CANNOT TRANSFER TO ZERO ADDRESS");
		require(transferAmount > 0, "TRANSFER AMOUNT 0");
		require(
			IERC20(erc20).transfer(recipient, transferAmount),
			"VaultDistrubution::sweep: transfer failed"
		);
	}
}