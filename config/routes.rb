Polymorph::Engine.routes.draw do
  post 'orderable/:orderable_type',
    to: 'orderable#create',
    as: :orderable
end
