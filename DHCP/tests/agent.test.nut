class AgentTestCase extends ImpTestCase {
  function setUp() {
    return "Hi from #{__FILE__}!";
  }

  function testSomething() {
    this.assertTrue(this instanceof ImpTestCase);
  }

  function tearDown() {
    return "Test finished";
  }
}
