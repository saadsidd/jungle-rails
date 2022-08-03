describe('jungle tests', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("Products show on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("Add first product to cart, goes from (0) to (1)", () => {
    cy.get('a[href="/cart"]').should('contain.text', 'My Cart (0)');
    cy.get('.products .button_to .btn').first().click({force: true});
    cy.get('a[href="/cart"]').should('contain.text', 'My Cart (1)');
  });

});