import { string } from '@ioc:Adonis/Core/Helpers'
import { LucidModel, manyToMany } from '@ioc:Adonis/Lucid/Orm';
import User from 'App/Models/User';


/**
 * Define manyToMany relationship by `usedPivot` hook
 * @returns {ManyToManyDecorator}
 */
const usePivot = <RelatedModel extends LucidModel>(model: () => RelatedModel, tag: string | null = null) => {
  var table = global
  return manyToMany(model, {
    pivotForeignKey: 'related_id',
    pivotRelatedForeignKey: string.singularize(model().table) + '_id',
    pivotTable: model().table + "_pivot",
    pivotColumns: ['tag'],
    onQuery: (builder) => {
      if (tag) {
        builder.wherePivot('tag', tag);
      }
    }
  });
}

/**
 * Define manyToMany relationship by `usedPivot` hook
 * @returns {ManyToManyDecorator}
 */
const usedPivot = <RelatedModel extends LucidModel, RelatedToModel extends LucidModel>(model: () => RelatedModel, to: () => RelatedToModel, tag: string | null = null) => manyToMany(model, {
  pivotForeignKey: string.singularize(to().table) + '_id',
  pivotRelatedForeignKey: 'related_id',
  pivotTable: to().table + "_pivot",
  pivotColumns: ['tag'],
  onQuery: (builder) => {
    if (tag) {
      builder.wherePivot('tag', tag)
    }
  }
})
export { usePivot, usedPivot };
