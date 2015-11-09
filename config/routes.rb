Polymorph::Engine.routes.draw do
  post 'orderable/:orderable_type',
    to: 'orderable#create',
    as: :orderable

  scope(:locale) do
    delete 'paranoid/:paranoid_type/:paranoid_id',
      to: 'paranoid#destroy',
      as: :paranoid
  end
end
