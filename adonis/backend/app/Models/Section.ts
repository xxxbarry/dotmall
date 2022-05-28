
// import { DateTime } from 'luxon'
// import { belongsTo, BelongsTo, column, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm'
// import DotBaseModel from '../../dot/models/DorBaseModel'
// import SectionTranslation from 'App/Models/translations/SectionTranslation'

// export default class Section extends DotBaseModel {
//   @column()
//   public storeId: string

//   @column()
//   public sectionId: string

//   @column()
//   public name: string

//   @column()
//   public description: string

//   @column()
//   public slug: string


//   @column.dateTime({ autoCreate: true })
//   public createdAt: DateTime

//   @column.dateTime({ autoCreate: true, autoUpdate: true })
//   public updatedAt: DateTime

//   @belongsTo(() => Section)
//   public parent: BelongsTo<typeof Section>

//   @hasMany(() => Section)
//   public children: HasMany<typeof Section>

//   @hasMany(() => SectionTranslation)
//   public translations: HasMany<typeof SectionTranslation>
// }
