describe('jungle tests', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("Products show on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it('Can navigate to page of first product', () => {
    cy.get(".products article").first().click();
  });

  it('Can see the stock of the product', () => {
    cy.get(".products article").first().click();
    cy.get(".quantity").first().should("contain.text", "18 in stock at ");
  });

});