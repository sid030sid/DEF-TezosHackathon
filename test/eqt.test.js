const EQT = artifacts.require("EQT")

contract('EQT', () => {
    let instance;
    let company;
  
    before(async() => {
      instance = await EQT.deployed();
      company = await instance.company();
      assert.equal(company.total_eqt, 0, "Ipo already done. Should not be the case.")
    });
  
    it("...should be a proper IPO", async() => {
      await instance.ipo(10, 5, 100);
      company = await instance.company();
      assert.equal(company.total_eqt, 10, "Total EQT not updated!");
      assert.equal(company.released_eqt, 5, "Released EQT amount not updated!");
      assert.equal(company.price, 100, "Price not updated!");

    });
    
    
    it("...should be a successful mint", async() => {
        await instance.ipo(10, 5, 100)
        company = await instance.company();
        assert.equal(company.released_eqt, 5, "Released EQT amount not updated!");

        await instance.mint(3);
        company = await instance.company();
        assert.equal(company.sold_eqt, 3, "Mint failed, but should actually succeed");
    });

    /*
    it("...should be a successful FPO", async() => {
        await instance.IPO(5);
        storage = await counterInstance.storage();
        assert.equal(storage, 5, "Storage was not incremented by 5.");
      });
      */
  });