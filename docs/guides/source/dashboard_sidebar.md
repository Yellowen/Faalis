**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://guides.faalis.io.**

Dashboard Sidebar
==================

This guide will get you started with sidebar menu of **Faalis** dashboard.

This guide covers the overview of dashboard sidebar and how it works.

After reading this guide, you will know:

* How to use Sidebar in dashboard
* How to populate the sidebar
* How authorization works with sidebar

--------------------------------------------------------------------------------

How sidebar works?
------------------
Sidebar is not very complicated. It's just a nested hash which **Faalis** uses it
to render a nested menu in dashboard. You can build this hash easily by yourself
and via any source you want. For example you can fetch the entries from database
of a remote API. But **Faalis** provides a simple DSL for you to build this hash
more easily. It's a bit limited but far from enough.

The best place to build your sidebar hash is in `Dashboard::ApplicationController`.
**Faalis** will generate a very besic skel for you to easily create your hash.

## Sidebar DSL

```ruby
  def setup_sidebar

    @sidebar = sidebar('') do |s|
      s.faalis_entries
      s.menu(t('Base Data'), icon: 'fa fa-book') do
        s.item(t('Provinces'),
               url: main_app.dashboard_provinces_path,
               model: 'Province')
        s.item(t('Cities'),
               url: main_app.dashboard_cities_path,
               model: 'City')
        s.item(t('Areas'),
               url: main_app.dashboard_areas_path,
               model: 'Area')
        s.item(t('Religions'),
               url: main_app.dashboard_religions_path,
               model: 'Religion')
      end
    end
  end
```
