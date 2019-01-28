/*
  This file is part of The Colony Network.

  The Colony Network is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  The Colony Network is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with The Colony Network. If not, see <http://www.gnu.org/licenses/>.
*/

pragma solidity >=0.4.23;


library SafeIntMath {
  int256 constant MIN_INT256 = -(2**255);

  function safeToAddInt(int a, int b) public pure returns (bool) {
    return (b >= 0 && a + b >= a) || (b < 0 && a + b < a);
  }

  function safeToSubInt(int a, int b) public pure returns (bool) {
    return (b >= 0 && a - b <= a) || (b < 0 && a - b > a);
  }

  function safeToMulInt(int a, int b) public pure returns (bool) {
    // https://github.com/JoinColony/colonyNetwork/issues/417
    // Note that if we ever add safeToDivInt, the same applies.
    if (((a == -1) && (b == MIN_INT256)) || ((b == -1) && (a == MIN_INT256))) {return false;}

    return (b == 0) || (a * b / b == a);
  }

  function addInt(int a, int b) public pure returns (int) {
    require(safeToAddInt(a, b), "colony-math-unsafe-int-add");
    return a + b;
  }

  function subInt(int a, int b) public pure returns (int) {
    require(safeToSubInt(a, b), "colony-math-unsafe-int-sub");
    return a - b;
  }

  function mulInt(int a, int b) public pure returns (int) {
    require(safeToMulInt(a, b), "colony-math-unsafe-int-mul");
    return a * b;
  }
}
