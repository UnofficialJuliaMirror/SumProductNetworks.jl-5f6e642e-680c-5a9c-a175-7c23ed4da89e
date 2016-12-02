export SPNNode, Node, Leaf, SumNode, ProductNode, IndicatorNode, UnivariateFeatureNode, UnivariateNode, NormalDistributionNode, MultivariateNode

# abstract definition of an SumProductNetwork node
abstract SPNNode
abstract Node <: SPNNode
abstract Leaf{T} <: SPNNode

#
# A sum node computes a weighted sum of its children.
#
immutable SumNode <: Node

  # * immutable fields * #
  id::Int
  isFilter::Bool

  # * mutable fields * #
	parents::Vector{SPNNode}
  children::Vector{SPNNode}
  weights::Vector{Float64}
  scope::Vector{Int}

  SumNode(id; parents = SPNNode[], scope = Int[]) = new(id, false, parents, SPNNode[], Float64[], scope)
  SumNode(id, children::Vector{SPNNode}, weights::Vector{Float64}; parents = SPNNode[], scope = Int[]) = new(id, false, parents, children, weights, scope)

end

#
# A product node computes a the product of its children.
#
immutable ProductNode <: Node

  # * immutable fields * #
  id::Int

  # * mutable fields * #
	parents::Vector{SPNNode}
  children::Vector{SPNNode}
  scope::Vector{Int}

  ProductNode(id; parents = SPNNode[], children = SPNNode[], scope = Int[]) = new(id, parents, children, scope)
end

# definition of indicater Node
immutable IndicatorNode <: Leaf

  # * immutable fields * #
  id::Int
  value::Int
  scope::Int

  # * mutable fields * #
	parents::Vector{SPNNode}

  IndicatorNode(id, value, scope::Int; parents = SPNNode[]) = new(id, value, scope, parents)
end

#
# A univariate node computes the likelihood of x under a univariate distribution.
#
immutable UnivariateFeatureNode <: Leaf

  # * immutable fields * #
  id::Int
  bias::Bool
  scope::Int

  # * mutable fields * #
	parents::Vector{SPNNode}

  UnivariateFeatureNode(id, scope::Int; parents = SPNNode[], isbias = false) = new(id, isbias, scope, parents)
end

#
# A univariate node computes the likelihood of x under a univariate distribution.
#
type UnivariateNode{T} <: Leaf

  # unique node identifier
  id::Int

  # Fields
	parents::Vector{SPNNode}
  dist::T
  scope::Int

  UnivariateNode{T}(id, distribution::T, scope::Int; parents = SPNNode[]) = new(id, parents, distribution, scope)
end

type NormalDistributionNode <: Leaf

  # unique node identifier
  id::Int

  # Fields
	parents::Vector{SPNNode}
  μ::Float64
  σ::Float64
  scope::Int

  NormalDistributionNode(id, scope::Int; parents = SPNNode[], μ = 0.0, σ = 1.0) = new(id, parents, μ, σ, scope)
end

#
# A multivariate node computes the likelihood of x under a multivariate distribution.
#
type MultivariateNode{T} <: Leaf

  # unique node identifier
  id::Int

  # Fields
	parents::Vector{SPNNode}
  dist::T
  scope::Vector{Int}

  MultivariateNode{T}(id, distribution::T, scope::Vector{Int}; parents = SPNNode[]) = new(id, parents, distribution, scope)

end
