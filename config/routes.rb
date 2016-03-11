Polymorph::Engine.routes.draw do
  scope '(:locale)' do
    post 'orderable/:orderable_type',
      to: 'orderable#create',
      as: :orderable

    delete 'paranoid/:paranoid_type/:paranoid_id',
      to: 'paranoid#destroy',
      as: :paranoid

    put 'publish/:publishable_type/:publishable_id',
      to: 'publishable#publish',
      as: :publish
  end
end
