/* globals artifacts */
import chai from "chai";
import bnChai from "bn-chai";

import { INT256_MAX, INT256_MIN } from "../helpers/constants";

chai.use(bnChai(web3.utils.BN));

const SafeIntMath = artifacts.require("SafeIntMath");

contract("SafeIntMath", () => {
  let safeMath;

  before(async () => {
    safeMath = await SafeIntMath.new();
  });

  it("multiplies ints correctly", async () => {
    const a = 5678;
    const b = -1234;
    const result = await safeMath.mulInt(a, b);
    assert.equal(result, a * b);
  });

  it("adds ints correctly", async () => {
    const a = 5678;
    const b = -1234;
    const result = await safeMath.addInt(a, b);
    assert.equal(result, a + b);
  });

  it("subtracts correctly", async () => {
    const a = -5678;
    const b = 1234;
    const result = await safeMath.subInt(a, b);
    assert.equal(result, a - b);
  });

  it("should throw an error on addition overflow", async () => {
    const a = INT256_MAX;
    const b = 1;

    const safe = await safeMath.safeToAddInt(a, b);
    assert.isFalse(safe);
  });

  it("should throw an error on addition underflow", async () => {
    const a = INT256_MIN;
    const b = 1;
    const safe = await safeMath.safeToAddInt(a, -b);
    assert.isFalse(safe);
  });

  it("should throw an error on subtraction underflow", async () => {
    const a = INT256_MIN;
    const b = 2;
    const safe = await safeMath.safeToSubInt(a, b);
    assert.isFalse(safe);
  });

  it("should throw an error on multiplication overflow", async () => {
    const a = INT256_MAX;
    const b = 2;
    const safe = await safeMath.safeToMulInt(a, b);
    assert.isFalse(safe);
  });
});
