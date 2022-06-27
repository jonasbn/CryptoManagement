require "minitest/autorun"
require "minitest/mock"
require_relative "../src/PortfolioManager.rb"
require_relative "../src/Portfolio.rb"
require_relative "../src/User.rb"

class PortfolioManagerTest < Minitest::Test

    def setup
        @portfolioManager = PortfolioManager.new()
        @portfolio = Portfolio.new("onePortfolio", User.new("username", "password"))
        @portfolio2 = Portfolio.new("anotherPortfolio", User.new("username", "password"))
    end

    def test_AddPortfolio
        @portfolioManager.AddPortfolio(@portfolio)

        assert_equal 1, @portfolioManager.GetNumPortfolios
        assert_equal "onePortfolio", @portfolioManager.GetPortfolio(@portfolio, User.new("username", "password")).name
    end

    def test_GetPortfolio_PortfolioExists_PortfolioReturned
        @portfolioManager.AddPortfolio(@portfolio)

        assert_equal 1, @portfolioManager.GetNumPortfolios
        assert_equal "onePortfolio", @portfolioManager.GetPortfolio(@portfolio, User.new("username", "password")).name
    end

    def test_GetPortfolio_PortfolioDoesNotExist_NilReturned
        @portfolioManager.AddPortfolio(@portfolio)

        assert_equal 1, @portfolioManager.GetNumPortfolios
        assert_nil @portfolioManager.GetPortfolio(@portfolio2, User.new("username", "password"))
    end

    def test_DeletePortfolio_PortfolioExists_PortfolioRemoved
        @portfolioManager.AddPortfolio(@portfolio)
        @portfolioManager.AddPortfolio(@portfolio2)

        @portfolioManager.DeletePortfolio(@portfolio)

        assert_equal 1, @portfolioManager.GetNumPortfolios
        assert_equal "anotherPortfolio", @portfolioManager.GetPortfolio(@portfolio2, User.new("username", "password")).name
    end

    def test_DeletePortfolio_PortfolioDoesNotExists_PortfolioNotRemoved
        @portfolioManager.AddPortfolio(@portfolio2)

        @portfolioManager.DeletePortfolio(@portfolio)

        assert_equal 1, @portfolioManager.GetNumPortfolios
    end
end